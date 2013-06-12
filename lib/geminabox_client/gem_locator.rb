module GeminaboxClient
  module GemLocator
    def find_gem(dir)
      gemname = File.split(dir).last
      glob_matcher = "{pkg/,}#{gemname}-*.gem"
      latest_gem_for(gemname, Dir.glob(glob_matcher)) or raise Gem::CommandLineError, NO_GEM_PROVIDED_ERROR_MESSAGE
    end

    def latest_gem_for(gemname, files)
      regexp_matcher = %r{(?:pkg/)#{gemname}-(#{Gem::Version::VERSION_PATTERN})\.gem}
      sorter = lambda{|v| Gem::Version.new(regexp_matcher.match(v)[1]) }
      files.grep(regexp_matcher).max_by(&sorter)
    end

    extend self

    NO_GEM_PROVIDED_ERROR_MESSAGE = "Couldn't find a gem in pkg, please specify a gem name on the command line (e.g. gem inabox GEMNAME)"
  end
end
