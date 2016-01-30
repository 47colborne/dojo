require 'spec_helper.rb'

describe 'Acceptance Tests' do
  let(:client) { CustomClient.new }
  let(:server) { CustomServer.new(2002) }

  before do
    @thread = Thread.new do
      server.start
    end

    client.connect(2002)
  end

  after do
    client.disconnect
    # @thread.kill
  end

  it 'responds to a HELO command with HELO' do
    expect(client.send_command('HELO')).to eq('HELO')
  end

  it 'responds to multiple HELO commands' do
    expect(client.send_command('HELO')).to eq('HELO')
    expect(client.send_command('HELO')).to eq('HELO')
  end

  it 'should be able to handle PWD to get working directory' do
    expect(client.send_command('PWD')).to eq(Dir.pwd)
  end

  it 'should be able to change the working directory with CD' do
    client.send_command('CD spec')
    expect(client.send_command('PWD')).to eq(File.expand_path('spec', Dir.pwd))
  end
end

describe CustomServer do
  subject(:server) { CustomServer.new(2001) }

  describe '#handle_command' do
    it 'should get the command handler from CommandHandler' do
      command = 'command'
      args = ['arg']
      handler = double(:handler)

      expect(handler).to receive(:call).with(*args).and_return 'response'
      expect(CommandHandler).to receive(:get_handler).with(command).and_return(handler)

      expect(server.handle_command(command, args)).to eq('response')
    end
  end

end

describe CommandHandler do
  subject { CommandHandler }
  describe '.get_handler' do
    it 'should return a handler for \'HELO\'' do
      expect(subject.get_handler('HELO')).to eq(subject::COMMANDS['HELO'])
    end

    it 'should return the invalid command handler if the command is not found' do
      expect(subject.get_handler('foo')).to eq(subject::INVALID_COMMAND_HANDLER)

    end
  end
end