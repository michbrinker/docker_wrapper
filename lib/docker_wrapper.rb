require "docker_wrapper/version"

module DockerWrapper
  class Error < StandardError; end

  class Image
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def pull(image)
      Open3.capture3("docker pull #{image}")
    end
  end
  
  class Container
    attr_reader :name, :image, :env, :vol, :opts, :command

    def initialize(name, options = {})
      @name = name
      @image = options.fetch(:image)
      @env = options.fetch(:env, nil)
      @vol = options.fetch(:vol, nil)
      @opts = options.fetch(:opts, nil)
    end

    def create(params = nil)
      env_params = @env.map { |e| "-e #{e}" }.join(' ') unless @env.nil?
      vol_params = @vol.map { |e| "-v #{e}" }.join(' ') unless @vol.nil?
      Open3.capture3("docker create -itd --name #{@name} #{env_params} #{vol_params} #{@opts} #{@image} #{params}")
    end

    def run(params = nil)
      env_params = @env.map { |e| "-e #{e}" }.join(' ') unless @env.nil?
      vol_params = @vol.map { |e| "-v #{e}" }.join(' ') unless @vol.nil?
      @command = "docker run -itd --name #{@name} #{env_params} #{vol_params} #{@opts} #{@image} #{params}"
      Open3.capture3(@command)
    end

    def exec(command)
      Open3.capture3("docker exec #{@name} #{command}")
    end

    def cp(source, dest)
      Open3.capture3("docker cp #{source} #{@name}:#{dest}")
    end

    def inspect
      Open3.capture3("docker inspect #{@name}")
    end

    def logs
      Open3.capture3("docker logs #{@name}")
    end

    def stop
      Open3.capture3("docker stop #{@name}")
    end

    def rm(force: false, link: false, vol: false)
      param = "#{ '-f ' if force }#{ '-l ' if link }#{ '-v ' if vol }"
      Open3.capture3("docker rm #{param}#{@name}")
    end

    def exit_status
      stdout, stderr, code = Open3.capture3("docker inspect #{@name} --format='{{.State.ExitCode}}'")
      stdout.to_i
    end

    def running?
      response = false
      begin
        out, err, status = Open3.capture3("docker inspect --format=\"{{.State.Running}}\" #{@name}")
        response = out == "true\n"
      end
      response
    end

    def to_s
      puts "Docker container instance #{@name}:"
      puts "with image: #{@image}"
      puts "env: #{@env}"
      puts "vol: #{@vol}"
      puts "opts: #{@opts}"
    end
  end

end
