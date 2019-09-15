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

module JekyllJupyterNotebook
  module IFramePage
    def output_ext
      ext + super
    end
  end

  class Generator < Jekyll::Generator
    def generate(site)
      site.static_files.reject! do |static_file|
        if static_file.extname == ".ipynb"
          base = static_file.instance_variable_get(:@base)
          dir = static_file.instance_variable_get(:@dir)
          name = static_file.name
          page = Jekyll::Page.new(site, base, dir, name)
          page.extend(IFramePage)
          site.pages << page
          true
        else
          false
        end
      end
    end
  end
end
