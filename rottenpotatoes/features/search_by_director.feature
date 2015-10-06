Feature: search for movies by director

  As a movie buff
  So that I can find movies with my favorite director
  I want to include and serach on director information in movies I enter

Background: movies in database

  Given the following movies exist:

  | title                   | rating | director  | release_date |
  | Aladdin                 | G      | Mark      | 25-Nov-1992  |
  | The Terminator          | R      |           | 26-Oct-1984  |
  | When Harry Met Sally    | R      |           | 21-Jul-1989  |
  | The Help                | PG-13  | Li Hue    | 10-Aug-2011  |
  | Chocolat                | PG-13  |           | 5-Jan-2001   |
  | Amelie                  | R      |           | 25-Apr-2001  |
  | 2001: A Space Odyssey   | G      | Li Hue    | 6-Apr-1968   |
  | The Incredibles         | PG     |           | 5-Nov-2004   |
  | Raiders of the Lost Ark | PG     |           | 12-Jun-1981  |
  | Chicken Run             | G      |           | 21-Jun-2000  |


Scenario: add director to existing movie
  When I go to the edit page for "The Help"
  And  I fill in "Director" with "Li Hue"
  And  I press "Update Movie Info"
  Then the director of "The Help" should be "Mark"

Scenario: find movie with same director
  Given I am on the details page for "The Help"
  When  I follow "Find Movies With Same Director"
  And   I should see "2001: A Space Odyssey"

Scenario: can't find similar movies if we don't know director (sad path)
  Given I am on the details page for "Aladdin"
  Then  I should not see "Mark"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the home page
  And   I should see "'Aladdin' has no director info"
