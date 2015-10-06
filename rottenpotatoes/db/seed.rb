user = Movie.find_by(director: '')
user.update_all(director: 'David')
