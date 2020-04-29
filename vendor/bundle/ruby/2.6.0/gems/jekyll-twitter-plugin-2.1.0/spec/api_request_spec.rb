# frozen_string_literal: true

RSpec.describe TwitterJekyll::ApiRequest do
  subject(:api_request) { described_class.new(url, params) }
  let(:url) { "https://twitter.com/twitter_user/status/12345" }
  let(:params) { {} }

  describe "#to_uri" do
    subject(:uri) { api_request.to_uri }

    it "uses correct api" do
      expect(uri.scheme).to eq "https"
      expect(uri.host).to eq "publish.twitter.com"
      expect(uri.path).to eq "/oembed"
    end

    context "with no params" do
      it "has url encoded query param" do
        expect(URI.decode_www_form(uri.query)).to match_array [["url", url]]
      end
    end

    context "with params" do
      let(:params) { { align: "right" } }

      it "has encoded query params" do
        expect(URI.decode_www_form(uri.query)).to match_array [["url", url], %w[align right]]
      end
    end

    context "with an incorrectly passed url param" do
      let(:params) { { url: "why" } }

      it "has uses the correct url" do
        expect(URI.decode_www_form(uri.query)).to match_array [["url", url]]
      end
    end
  end

  describe "#cache_key" do
    let(:url) { ["https://twitter.com/twitter_user/status/12345"] }

    context "with no params" do
      it "matches on status url" do
        request_one = described_class.new(url, {})
        request_two = described_class.new(url, {})

        expect(
          request_one.cache_key == request_two.cache_key
        ).to be true
      end

      it "fails if different" do
        request_one = described_class.new(url, {})
        request_two = described_class.new("https://twitter.com/other_user/status/12345", {})

        expect(
          request_one.cache_key == request_two.cache_key
        ).to be false
      end
    end

    context "with params" do
      it "matches on keys and values" do
        request_one = described_class.new(url, align: "left")
        request_two = described_class.new(url, align: "left")

        expect(
          request_one.cache_key == request_two.cache_key
        ).to be true
      end

      it "fails if different" do
        request_one = described_class.new(url, align: "left")
        request_two = described_class.new(url, align: "right")

        expect(
          request_one.cache_key == request_two.cache_key
        ).to be false
      end
    end
  end
end
