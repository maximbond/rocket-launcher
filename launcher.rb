class Launcher
  def initialize(app_map)
    @app_map = app_map
  end

  def run(file, args = nil)
    handler(file).run(file, args)
  end

  private

  def handler(file)
    get_handler(file) || build_handler(file)
  end
  
  def get_handler(file)
    begin
      current_path = File.expand_path(File.dirname(__FILE__))
      ftype = file_type(file)

      require "#{current_path}/handlers/#{ftype}"
      Object.const_get(ftype.capitalize).new
    rescue Exception
      nil
    end
  end

  def build_handler(file)
    handler = Class.new
    application = select_app(file)

    eval "def handler.run(file, args = nil)
      system '#{application} #{file}'
    end"

    handler
  end

  def select_app(file)
    ftype = file_type(file).downcase

    @app_map[ftype.to_sym]
  end

  def file_type(file)
    File.extname(file).gsub(/^\./, '')
  end
end
