require 'spec_helper'

describe Movie do
	describe 'searching similar directors' do
    	it 'should call Movie with director' do
      Movie.should_receive(:similar_directors).with('Aladdin')
      Movie.similar_directors('Aladdin')
    end
  end
end
