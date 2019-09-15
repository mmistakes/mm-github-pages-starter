# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "tempfile"

module JekyllJupyterNotebook
  class Converter < Jekyll::Converter
    def matches(ext)
      ext == ".ipynb"
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      config = @config["jupyter_notebook"] || {}

      html = convert_notebook(content)
      html.sub!(/<link.+?href="custom.css">/, "")
      case config["content"] || "html"
      when "html"
      when "body"
        html.sub!(/\A.*?<\/title>/m, "")
        html.sub!(/<\/head>/, "")
        html.sub!(/<body>/, "")
        html.sub!(/<\/body>.*?\z/m, "")
      when "body-without-style"
        html.sub!(/\A.*?<body>/m, "")
        html.sub!(/<\/body>.*?\z/m, "")
      end
      html
    end

    private
    def convert_notebook(content)
      notebook = Tempfile.new(["jekyll-jupyter-notebook", ".ipynb"])
      notebook.print(content)
      notebook.close
      IO.pipe do |input, output|
        pid = spawn("jupyter",
                    "nbconvert",
                    "--to", "html",
                    "--stdout",
                    notebook.path,
                    :out => output)
        begin
          output.close
          html = nil
          read_thread = Thread.new do
            html = input.read
          end
          read_thread.join
          html
        ensure
          Process.waitpid(pid)
        end
      end
    end
  end
end
