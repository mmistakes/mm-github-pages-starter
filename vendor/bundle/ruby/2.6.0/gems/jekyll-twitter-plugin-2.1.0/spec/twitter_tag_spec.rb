# frozen_string_literal: true

RSpec.describe TwitterJekyll::TwitterTag do
  let(:api_response_hash) do
    {
      "url" => "https://twitter.com/twitter_user/status/12345",
      "author_name" => "twitter user",
      "author_url" => "https://twitter.com/twitter_user",
      "html" => "<p>tweet html</p>",
      "width" => 550,
      "height" => nil,
      "type" => "rich",
      "cache_age" => "3153600000",
      "provider_name" => "Twitter",
      "provider_url" => "https://twitter.com",
      "version" => "1.0"
    }
  end

  shared_context "without cached response" do
    let(:cache) { null_cache }

    before do
      subject.cache = cache
    end

    def null_cache
      double("TwitterJekyll::NullCache", read: nil, write: nil)
    end
  end

  shared_context "called with deprecated oembed argument url" do
    # {% twitter oembed https://twitter.com/twitter_user/status/12345 option=value %}
    let(:arguments) { "oembed https://twitter.com/twitter_user/status/12345" }
    let(:context) { empty_jekyll_context }

    subject { described_class.new(nil, arguments, nil) }
  end

  shared_context "called with url" do
    # {% twitter https://twitter.com/twitter_user/status/12345 option=value %}
    let(:arguments) { "https://twitter.com/twitter_user/status/12345" }
    let(:context) { empty_jekyll_context }

    subject { described_class.new(nil, arguments, nil) }
  end

  shared_context "called with a page var" do
    # {% twitter page.tweet option=value %}
    let(:arguments) { "page.tweet" }
    let(:context) { jekyll_context_with(arguments, params) }
    let(:params) { "https://twitter.com/twitter_user/status/12345" }

    subject { described_class.new(nil, arguments, nil) }
  end

  shared_context "called in a loop with a local var" do
    # This is the same as above but ensures that same instance can render different contexts
    # {% for tweet in page.tweets %}
    #   {% twitter tweet option=value %}
    # {% endfor %}
    let(:arguments) { "tweet" }
    let(:context) { jekyll_context_with(arguments, params) }
    let(:params) { "https://twitter.com/twitter_user/status/12345" }

    subject { described_class.new(nil, arguments, nil) }
  end

  shared_examples "it does not allow empty arguments" do
    context "without any arguments" do
      let(:arguments) { "" }

      it "raises an exception" do
        expect_to_raise_invalid_args_error(arguments) do
          subject.render(context)
        end
      end
    end
  end

  shared_examples "it uses a cached response" do
    context "with cached response" do
      let(:cache) { double("TwitterJekyll::FileCache") }
      before do
        subject.cache = cache
      end

      let(:arguments) { "https://twitter.com/twitter_user/status/12345" }

      it "renders response from cache" do
        expect(cache).to receive(:read).with(an_instance_of(String)).and_return(api_response_hash)

        output = subject.render(context)
        expect_output_to_match_tag_content(output, api_response_hash.fetch("html"))
      end
    end
  end

  shared_examples "it handles api responses" do
    context "with successful api request" do
      before do
        stub_api_request(status: 200, body: api_response_hash.to_json, headers: {})
      end

      it "renders response from api and writes to cache" do
        expect(cache).to receive(:write).with(an_instance_of(String), api_response_hash)

        output = subject.render(context)
        expect_output_to_match_tag_content(output, api_response_hash.fetch("html"))
      end
    end

    context "with a status not found api request" do
      before do
        stub_api_request(status: [404, "Not Found"], body: "", headers: {})
      end

      it "renders error response and writes to cache" do
        expect(cache).to receive(:write).with(an_instance_of(String), an_instance_of(Hash))

        output = subject.render(context)
        expect_output_to_have_error(output, "Not Found")
      end
    end

    context "with a status request not permitted api request" do
      before do
        stub_api_request(status: [403, "Forbidden"], body: "", headers: {})
      end

      it "renders error response and writes to cache" do
        expect(cache).to receive(:write).with(an_instance_of(String), an_instance_of(Hash))

        output = subject.render(context)
        expect_output_to_have_error(output, "Forbidden")
      end
    end

    context "with a server error api request" do
      before do
        stub_api_request(status: [500, "Internal Server Error"], body: "", headers: {})
      end

      it "renders error response and writes to cache" do
        expect(cache).to receive(:write).with(an_instance_of(String), an_instance_of(Hash))

        output = subject.render(context)
        expect_output_to_have_error(output, "Internal Server Error")
      end
    end

    context "with api request that times out" do
      before do
        stub_api.to_timeout
      end

      it "renders error response and writes to cache" do
        expect(cache).to receive(:write).with(an_instance_of(String), an_instance_of(Hash))

        output = subject.render(context)
        expect_output_to_have_error(output, "Net::OpenTimeout")
      end
    end
  end

  describe "output from oembed request" do
    include_context "called with deprecated oembed argument url"

    it_behaves_like "it does not allow empty arguments"
    it_behaves_like "it uses a cached response"

    context "without cached response" do
      include_context "without cached response"

      it "uses correct twitter url and warns of deprecation" do
        api_client = api_client_double
        allow(api_client).to receive(:fetch).and_return({})
        allow(TwitterJekyll::ApiClient).to receive(:new).and_return(api_client)
        allow(TwitterJekyll::ApiRequest).to receive(:new).with("https://twitter.com/twitter_user/status/12345", {}).and_call_original
        allow(cache).to receive(:write)

        expect do
          subject = described_class.new(nil, arguments, nil)
          subject.render(context)
        end.to output(/Passing 'oembed' as the first argument is not required anymore/).to_stderr

        expect(TwitterJekyll::ApiRequest).to have_received(:new).with("https://twitter.com/twitter_user/status/12345", {})
      end

      context "with options" do
        let(:arguments) { "oembed https://twitter.com/twitter_user/status/12345 align=right width=350" }

        it "passes options to api" do
          api_client = api_client_double
          allow(api_client).to receive(:fetch).and_return({})
          allow(TwitterJekyll::ApiClient).to receive(:new).and_return(api_client)
          allow(TwitterJekyll::ApiRequest).to receive(:new).with("https://twitter.com/twitter_user/status/12345", "align" => "right", "width" => "350").and_call_original
          allow(cache).to receive(:write)

          subject = described_class.new(nil, arguments, nil)
          subject.cache = cache
          subject.render(context)

          expect(TwitterJekyll::ApiRequest).to have_received(:new)
            .with("https://twitter.com/twitter_user/status/12345", "align" => "right", "width" => "350")
        end
      end

      it_behaves_like "it handles api responses"
    end
  end

  describe "output from url request" do
    include_context "called with url"

    it_behaves_like "it does not allow empty arguments"
    it_behaves_like "it uses a cached response"

    context "without cached response" do
      include_context "without cached response"

      it "uses correct twitter url" do
        api_client = api_client_double
        allow(api_client).to receive(:fetch).and_return({})
        allow(TwitterJekyll::ApiClient).to receive(:new).and_return(api_client)
        allow(TwitterJekyll::ApiRequest).to receive(:new).with("https://twitter.com/twitter_user/status/12345", {}).and_call_original
        allow(cache).to receive(:write)

        subject = described_class.new(nil, arguments, nil)
        subject.render(context)

        expect(TwitterJekyll::ApiRequest).to have_received(:new).with("https://twitter.com/twitter_user/status/12345", {})
      end

      context "with options" do
        let(:arguments) { "https://twitter.com/twitter_user/status/12345 align=right width=350" }

        it "passes options to api" do
          api_client = api_client_double
          allow(api_client).to receive(:fetch).and_return({})
          allow(TwitterJekyll::ApiClient).to receive(:new).and_return(api_client)
          allow(TwitterJekyll::ApiRequest).to receive(:new).with("https://twitter.com/twitter_user/status/12345", "align" => "right", "width" => "350").and_call_original
          allow(cache).to receive(:write)

          subject = described_class.new(nil, arguments, nil)
          subject.render(context)

          expect(TwitterJekyll::ApiRequest).to have_received(:new)
            .with("https://twitter.com/twitter_user/status/12345", "align" => "right", "width" => "350")
        end
      end

      it_behaves_like "it handles api responses"
    end
  end

  describe "output from usage with front matter var" do
    include_context "called with a page var"

    it_behaves_like "it does not allow empty arguments" do
      let(:arguments) { "page.tweet" }
      let(:context) { empty_jekyll_context }
      let(:params) { "" }
    end

    it_behaves_like "it uses a cached response"

    context "without cached response" do
      include_context "without cached response"

      it "uses correct twitter url" do
        api_client = api_client_double
        allow(api_client).to receive(:fetch).and_return({})
        allow(TwitterJekyll::ApiClient).to receive(:new).and_return(api_client)
        allow(TwitterJekyll::ApiRequest).to receive(:new).with("https://twitter.com/twitter_user/status/12345", {}).and_call_original
        allow(cache).to receive(:write)

        subject = described_class.new(nil, arguments, nil)
        subject.render(context)

        expect(TwitterJekyll::ApiRequest).to have_received(:new).with("https://twitter.com/twitter_user/status/12345", {})
      end

      context "with options" do
        let(:arguments) { "page.tweet align=left width=400" }
        let(:context) { jekyll_context_with("page.tweet", params) }
        let(:params) { "https://twitter.com/twitter_user/status/12345" }

        it "passes options to api" do
          api_client = api_client_double
          allow(api_client).to receive(:fetch).and_return({})
          allow(TwitterJekyll::ApiClient).to receive(:new).and_return(api_client)
          allow(TwitterJekyll::ApiRequest).to receive(:new).with("https://twitter.com/twitter_user/status/12345", "align" => "left", "width" => "400").and_call_original
          allow(cache).to receive(:write)

          subject = described_class.new(nil, arguments, nil)
          subject.render(context)

          expect(TwitterJekyll::ApiRequest).to have_received(:new)
            .with("https://twitter.com/twitter_user/status/12345", "align" => "left", "width" => "400")
        end
      end

      it_behaves_like "it handles api responses"
    end
  end

  describe "output from usage in a loop with a local var" do
    include_context "called in a loop with a local var"

    it_behaves_like "it does not allow empty arguments" do
      let(:arguments) { "tweet" }
      let(:context) { empty_jekyll_context }
      let(:params) { "" }
    end

    it_behaves_like "it uses a cached response"

    context "without cached response" do
      include_context "without cached response"

      it "uses correct twitter url" do
        api_client = api_client_double
        allow(api_client).to receive(:fetch).and_return({})
        allow(TwitterJekyll::ApiClient).to receive(:new).and_return(api_client)
        allow(TwitterJekyll::ApiRequest).to receive(:new).with("https://twitter.com/twitter_user/status/12345", {}).and_call_original
        allow(cache).to receive(:write)

        subject = described_class.new(nil, arguments, nil)
        subject.render(context)

        expect(TwitterJekyll::ApiRequest).to have_received(:new).with("https://twitter.com/twitter_user/status/12345", {})
      end

      it "handles many contexts passed to same instance" do
        api_client = api_client_double
        allow(api_client).to receive(:fetch).and_return({})
        allow(TwitterJekyll::ApiClient).to receive(:new).and_return(api_client)
        allow(TwitterJekyll::ApiRequest).to receive(:new).with("https://twitter.com/twitter_user/status/first_url", {}).and_call_original
        allow(TwitterJekyll::ApiRequest).to receive(:new).with("https://twitter.com/twitter_user/status/second_url", {}).and_call_original
        allow(cache).to receive(:write)

        context = double("context", registers: { site: double(config: {}) }).tap do |c|
          allow(c).to receive(:[]).with(arguments).and_return(
            "https://twitter.com/twitter_user/status/first_url",
            "https://twitter.com/twitter_user/status/second_url"
          )
        end

        subject = described_class.new(nil, arguments, nil)
        subject.render(context)
        subject.render(context)

        expect(TwitterJekyll::ApiRequest).to have_received(:new).with("https://twitter.com/twitter_user/status/first_url", {})
        expect(TwitterJekyll::ApiRequest).to have_received(:new).with("https://twitter.com/twitter_user/status/second_url", {})
      end

      context "with options" do
        let(:arguments) { "tweet align=middle width=500" }
        let(:context) { jekyll_context_with("tweet", params) }
        let(:params) { "https://twitter.com/twitter_user/status/12345" }

        it "passes options to api" do
          api_client = api_client_double
          allow(api_client).to receive(:fetch).and_return({})
          allow(TwitterJekyll::ApiClient).to receive(:new).and_return(api_client)
          allow(TwitterJekyll::ApiRequest).to receive(:new).with("https://twitter.com/twitter_user/status/12345", "align" => "middle", "width" => "500").and_call_original
          allow(cache).to receive(:write)

          subject = described_class.new(nil, arguments, nil)
          subject.render(context)

          expect(TwitterJekyll::ApiRequest).to have_received(:new)
            .with("https://twitter.com/twitter_user/status/12345", "align" => "middle", "width" => "500")
        end
      end

      it_behaves_like "it handles api responses"
    end
  end

  describe "parsing api secrets" do
    include_context "called with url"
    include_context "without cached response"

    before do
      stub_api_request(status: 200, body: api_response_hash.to_json, headers: {})
    end

    context "with api secrets provided by ENV" do
      let(:context) { double("context", registers: { site: double(config: {}) }) }
      before do
        stub_const("ENV", "TWITTER_CONSUMER_KEY" => "consumer_key",
                          "TWITTER_CONSUMER_SECRET" => "consumer_secret",
                          "TWITTER_ACCESS_TOKEN" => "access_token",
                          "TWITTER_ACCESS_TOKEN_SECRET" => "access_token_secret")
      end

      it "warns of deprecation" do
        expect do
          tag = described_class.new(nil, arguments, nil)
          tag.render(context)
        end.to output(/Found Twitter API keys in ENV, this library does not require these keys anymore/).to_stderr
      end
    end

    context "with api secrets provided by Jekyll config" do
      let(:context) do
        api_secrets = %w[consumer_key consumer_secret access_token access_token_secret]
                      .each_with_object({}) { |secret, h| h[secret] = secret }
        double("context", registers:
          { site: double(config: { "twitter" => api_secrets }) })
      end
      before do
        stub_const("ENV", {})
      end

      it "warns of deprecation" do
        expect do
          tag = described_class.new(nil, arguments, nil)
          tag.render(context)
        end.to output(/Found Twitter API keys in Jekyll _config.yml, this library does not require these keys anymore/).to_stderr
      end
    end

    context "with no api secrets provided" do
      let(:context) { empty_jekyll_context }
      before do
        stub_const("ENV", {})
      end

      it "does not warn" do
        expect do
          subject.render(context)
        end.to_not output.to_stderr
      end
    end
  end

  private

  def stub_api_request(response)
    stub_api
      .to_return(response)
  end

  def stub_api
    stub_request(:get, /publish.twitter.com/)
  end

  def empty_jekyll_context
    double("context", registers: { site: double(config: {}) }, :[] => nil)
  end

  def jekyll_context_with(var, params)
    double("context", registers: { site: double(config: {}) }).tap do |c|
      allow(c).to receive(:[]).with(var).and_return(params)
    end
  end

  def api_client_double
    double("TwitterJekyll::ApiClient")
  end

  def expect_output_to_match_tag_content(actual, content)
    expect(actual).to eq(
      "<div class='jekyll-twitter-plugin'>#{content}</div>"
    )
  end

  def expect_output_to_have_error(actual, error, tweet_url = "https://twitter.com/twitter_user/status/12345")
    expect_output_to_match_tag_content(actual, "<p>There was a '#{error}' error fetching URL: '#{tweet_url}'</p>")
  end

  def expect_to_raise_invalid_args_error(arguments)
    raise unless block_given?

    message = "Invalid arguments '#{arguments}' passed to 'jekyll-twitter-plugin'. Please see 'https://github.com/rob-murray/jekyll-twitter-plugin' for usage."
    expect do
      yield
    end.to raise_error(ArgumentError, message)
  end
end
