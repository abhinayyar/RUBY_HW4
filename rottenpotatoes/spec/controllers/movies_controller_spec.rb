require 'spec_helper'

describe MoviesController do

describe 'add director' do
	before :each do
      		@m=mock(Movie, :title => "Aladdin", :director => "Mark", :id => "1")
      		Movie.stub!(:find).with("1").and_return(@m)
    	end
    	it 'should call update_attributes and redirect' do
      		@m.stub!(:update_attributes!).and_return(true)
      		put :update, {:id => "1", :movie => @m}
      		response.should redirect_to(movie_path(@m))
    	end
end

describe 'happy path' do
	before :each do
		@movie_id = 1
		@founded = [mock('a movie'), mock('another one')]
		@fake_movie.stub(:director).and_return('fake director')
	end
	it 'should render same_director view' do
		Movie.stub(:find).and_return(@fake_movie)
		Movie.stub(:similar_directors).and_return(@founded)

		get :same_director, {:id => @movie_id}
		response.should render_template 'same_director'
	end
	it 'should render same_director view' do
		Movie.stub(:find).and_return(@fake_movie)
		Movie.stub(:similar_directors).and_return(@founded)

		get :same_director, {:id => @movie_id}
		response.should render_template 'same_director'
	end
	it 'should call Model method to get movies with same director' do
		Movie.should_receive(:find).with(@movie_id.to_s).and_return(@fake_movie)
		Movie.should_receive(:similar_directors).and_return(@founded)

		get :same_director, {:id => @movie_id}
	end
	it 'should make founded movies available to the view' do
		Movie.stub(:find).and_return(@fake_movie)
		Movie.stub(:similar_directors).and_return(@founded)

		get :same_director, {:id => @movie_id}

		assigns(:movies).should == @founded
	end
end

describe 'sad path' do
	before :each do
		@movie_id = 1
		@founded = [mock('a movie'), mock('another one')]
		@fake_movie.stub(:director).and_return('fake director')
	end
	it 'should redirect to home  and generate a flash' do
		empty_director =  double('movie', :director => '').as_null_object
		Movie.stub(:find).and_return(empty_director)
		Movie.stub(:similar_directors)
			
		get :same_director, {:id => @movie_id}
		response.should redirect_to(movies_path)
      		flash[:notice].should_not be_blank
    	end
end
before :each do
		@fake_movie = stub('double').as_null_object
		@movie = [mock('movie1')]
end
describe 'updating movie info' do
	before :each do
		movie_id = 5
		Movie.should_receive(:find).with(movie_id.to_s).and_return(@fake_movie)
		@fake_movie.should_receive(:update_attributes!).exactly 1
		put :update, {:id => movie_id, :movie => @movie}
	end
	it 'should call the model method that performs the movie update' do
		true
	end
	it 'should redirect to details template for rendering' do
		response.should redirect_to(movie_path @fake_movie)
	end
	it 'should make updated info available to template' do
		assigns(:movie).should == @fake_movie
	end
end

describe 'create and destroy' do
	it 'should create a new movie' do
      		MoviesController.stub(:create).and_return(mock('Movie'))
      		post :create, {:id => "1"}
    	end
    	it 'should destroy a movie' do
      		m = mock(Movie, :id => "10", :title => "blah", :director => nil)
      		Movie.stub!(:find).with("10").and_return(m)
      		m.should_receive(:destroy)
      	delete :destroy, {:id => "10"}
    	end
end
  
end
