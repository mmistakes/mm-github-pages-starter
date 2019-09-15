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

require "tmpdir"

module JekyllJupyterNotebook
  class Tag < Liquid::Tag
    Liquid::Template.register_tag("jupyter_notebook", self)

    def initialize(tag_name, markup, parse_context)
      super
    end

    def syntax_example
      "{% #{@tag_name} \"filename.ipynb\" %}"
    end

    def render(context)
      variable = Liquid::Variable.new(@markup, @parse_context)
      notebook_path = variable.render(context)
      if notebook_path.nil?
        Jekyll.logger.warn("Warning:",
                           "Jupyter Notebook path be string literal: " +
                           "<#{@markup.strip.inspect}>")
        notebook_path = @markup.strip # For backward compatibility
      end
      notebook_html_path = "#{notebook_path}.html"
      <<-HTML
<div
  class="jupyter-notebook"
  style="position: relative; width: 100%; margin: 0 auto;">
  <div class="jupyter-notebook-iframe-container">
    <iframe
      src="#{CGI.escapeHTML(notebook_html_path)}"
      style="position: absolute; top: 0; left: 0; border-style: none;"
      width="100%"
      height="100%"
      onload="this.parentElement.style.paddingBottom = (this.contentWindow.document.documentElement.scrollHeight + 10) + 'px'"></iframe>
  </div>
</div>
      HTML
    end
  end
end
