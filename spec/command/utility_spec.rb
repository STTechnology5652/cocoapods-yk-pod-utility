require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Utility do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ utility }).should.be.instance_of Command::Utility
      end
    end
  end
end

