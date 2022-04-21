# Lab 6 (Group 7)

This is a "Peer Evaluation" tool that allows students to leave feedback about
their team members, and instructors to view this feedback.

### Useful Links

- [In-Class Presentation Slides](https://docs.google.com/presentation/d/1o48s52hvurLMoaTE5CMQ0-u7-w9cBnNkxgf_ow6RoVg/edit?usp=sharing)
- [Instance running on Heroku](https://cse3901-group-7-lab-6.herokuapp.com/)
  - You can reset the Heroku instance by going to [this page](https://cse3901-group-7-lab-6.herokuapp.com/full-system-reset-for-testing-only)
    and entering the reset key: `0c90301e-0b89-4840-b42b-0a86d3eef8d4`
- [Techincal Design Google Doc](https://docs.google.com/document/d/1KgCAbVPM08bGoA2ufydmyairl9aemQLfCDW1XnZ03Us/edit?usp=sharing)
- [Project Requirements](http://web.cse.ohio-state.edu/~giles.25/3901/labs/project6.html)

### Running

This project was written for `ruby 3.0.1` and `rails 6.1.x`. Ensure you've followed the [VM setup instructions](http://web.cse.ohio-state.edu/~giles.25/3901/resources/vm-install.html)

Now, to run the project:
```bash
# To install dependencies
$ bundle install
[...]
$ rails yarn:install
[...]

# To create the database
$ rails db:migrate

# To run
$ rails server
```

### Who wrote what controller

- Adrian Vovk
  - Application
  - Evaluations
  - FeedbackItems
- Evan Porter
  - Instructors
- Kaiyuan Zheng
  - Students 
- Chris Zhao 
  - Projects
  - Groups
