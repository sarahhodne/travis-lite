Want to contribute to Travis Lite? Awesome! Here's a quick guide:

1. Fork the repository.
2. Run the tests. Pull requests will only be accepted if the tests are passing, and it's great to know that you have a
   clean slate: `bundle install && rake`.
3. Add tests for your change. Only refactoring and documentation changes require no new test. If you're adding
   functionality or fixing a bug, a test is needed to make sure it's not broken in the future.
4. Make the tests pass.
5. Push to your fork and submit a pull request.

Note that there are some classes that aren't tested right now: the view classes, the API class and the Application
class. This is pretty much because I don't know exactly how to add tests to them yet, so I will accept pull requests
that do not add tests for those classes. If you have suggestions for testing those classes, please send a pull request.
