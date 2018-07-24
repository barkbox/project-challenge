# Overview

This is a private version of the project repo we send to candidates. It's a basic Rails CRUD app for displaying and editing dog profiles, where candidates can refactor existing code and add features as part of a technical assesment. Setup instructions are in the readme of the [public repo](https://github.com/barkbox/project-challenge).

# Challenge Ideas

### Backend/Fullstack
* Add pagination to index page, to display 5 dogs per page
* Add the ability to for a user to input multiple dog images on an edit form or new dog form
* Associate dogs with owners
* Allow editing only by owner
* Allow users to like other dogs (not their own)
  * Allow sorting the index page by number of likes in the last hour
* Display the ad.jpg image (saved at app/assets/images/ad.jpg) after every 2 dogs in the index page, to simulate advertisements in a feed.

### Frontend
* On the dog detail page that has more than one profile image, (ex http://localhost:3000/dogs/1), display profile images in a functioning carousel.
  * Feel free to use vanilla JS or a carousel library.
* Use flexbox, CSS grids, or a grid framework to display the homepage's dog profile thumbnails in a responsive grid layout.
  * On mobile, the thumbnails should be 1 across, on tablet they should be 2 across, and on desktop they should be 3 across.
* Use utility classes within a layout framework (Bootstrap, Foundation, Material Design, or another) to add a structured layout to the page without custom CSS.
* Refactor the homepage from its current state as a server-rendered page to a client-rendered page, where you request data from `/dogs.json` and display data from the response. Feel free to use a front-end framework, jQuery, or vanilla JS.

Note: This project is based on a Rails 5 boilerplate scaffold. New styles can be added to app/assets/stylesheets/application.css, and new JS can be added to app/assets/javascripts/application.js. If you choose to add external CSS or JS, you can add a CDN hosted-library to a `<link>` or a `<script>` tag in app/views/layouts/application.html.erb.

# Additional Questions
- What would you change before putting this on production?

# Challenge Solutions
As we come up with solutions for these challenges, we will add them as branches.

