require 'open3'

RSpec.describe DockerWrapper do
  it 'has a version number' do
    expect(DockerWrapper::VERSION).not_to be nil
  end

  it 'can create and remove a docker container' do
    docker = DockerWrapper::Container.new('test', image: 'hello-world', volume: ['/tmp/test:/test'])
    docker.run
    expect(docker).to be_truthy
    expect(docker.logs.first).to include('Hello from Docker!')
    
    docker.rm(force: true)
    expect(docker.exit_status).to eq(0)
  end
end
