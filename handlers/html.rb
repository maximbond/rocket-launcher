class Html
  DEFAULT_BROWSER = '/usr/bin/google-chrome-stable'

  def run(file, args)
    if args.nil? || args.empty?
      system "#{DEFAULT_BROWSER} #{file}" 
    else
      call_with_params(file, args)
    end
  end

  def call_with_params(file, args)
    cmd = args.is_a?(String) ? args : args.shift
    send("do_#{cmd}", file, args)
  end

  def do_firefox(file, args)
    system "firefox #{file} #{args}"
  end
end
