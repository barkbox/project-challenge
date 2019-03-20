# Welcome

This repository contains starter code for a technical assessment. The challenges can be done at home before coming in to discuss with the Bark team or can be done as a pairing exercise at the Bark office. Either way, we don't expect you to put more than an hour or two into coding. We recommend forking the repository and getting it running before starting the challenge if you choose the pairing approach.

# Set up

Fork this repository and clone locally

You'll need [ruby 2.2.4](https://rvm.io/rvm/install) and [rails 5](http://guides.rubyonrails.org/getting_started.html#installing-rails) installed.

Run `bundle install`

Initialize the data with `rake db:reset`

Run the specs with `rspec`

Run the server with `rails s`

View the site at http://localhost:3000

# Backend

## Add pagination to index page, to display 5 dogs per page

app/controllers/dogs_controller.rb

```ruby
@dogs = Dog.paginate(page: params[:page], :per_page => 5)
```

app/views/_dogs.html.erb
```ruby
<%= will_paginate @dogs, renderer: BootstrapPagination::Rails %>
```
## Add the ability to for a user to input multiple dog images on an edit form or new dog form

app/views/_form.html.erb
```ruby
<%= f.input :images, as: :file, :input_html => { :multiple => true } %>
```

app/controllers/dogs_controller.rb
```ruby
 def dog_params
      params.require(:dog).permit(:name, :description, images: [])
    end
```

## Associate dogs with owners

app/models/dog.rb
```ruby
  belongs_to :owner, optional: true,
    primary_key: :id,
    foreign_key: :owner_id,
    class_name: 'User'
```

## Allow editing only by owner
app/controllers/dogs_controller.rb
```ruby
 before_action :require_login, only: [:new, :create]
```

app/controllers/application_controller.rb
```ruby
def require_login
    redirect_to dogs_url unless current_user
  end
```
app/views/show.html.erb
```ruby
<% if current_user && current_user.id == @dog.owner_id %>
      <%= link_to "Edit #{@dog.name}'s Profile", edit_dog_path %>
      <%= link_to "Delete #{@dog.name}'s Profile", dog_path, method: :delete, data: { confirm: 'Are you sure?' } %>
    <% end %>
```

## Allow users to like other dogs (not their own)

app/controller/likes_controller.rb
```ruby
class LikesController < ApplicationController
  before_action :require_login

  def create
    @like = Like.new(like_params)
    @like.liker_id = current_user.id
    @like.dog_id = params[:dog_id]

    respond_to do |format|
      if @like.save
        @dog = Dog.find(params[:dog_id])

        format.html { redirect_to @dog } 
        format.json { render :show, status: :created, location: @dog }

      else
        format.json { render json: @like.errors.full_messages, status: 422 }
      end
    end

  end

  def destroy
    @like = Like.find(params[:id])  
    @dog = Dog.find(@like.dog_id)
    @like.destroy

    respond_to do |format|
      format.html { redirect_to @dog } 
    end
  end

  private
  def like_params
    params.permit(:dog_id, :liker_id)
  end
end
```

app/views/show.html.erb
```ruby
  <% if current_user && @dog.owner_id != current_user.id %>
      <% if @like %>
        <%= link_to "Unlike", like_url(@like.id), method: :delete %>
      <% else %>
        <%= link_to "Like", dog_likes_url(@dog), method: :post %>
      <% end %>
    <% end %>
```

## Allow sorting the index page by number of likes in the last hour
app/controllers/dogs_controller.rb
```ruby
 def index
    if params[:sort_params]   
      subquery = Like.select(:id, :dog_id, :user_id).where(created_at: (Time.now - 1.hour)..Time.now)
      @dogs = Dog.paginate(page: params[:page], :per_page => 5)
                  .joins("LEFT JOIN (#{subquery.to_sql}) AS likes ON dogs.id = likes.dog_id")
                  .group(:id)
                  .order("count(likes.id) desc")
    else
      @dogs = Dog.paginate(page: params[:page], :per_page => 5)
    end
  end
```


## Display the ad.jpg image after every 2 dogs in the index page

```ruby
<% if dog_counter % 2 == 1 %>
  <div class="col-lg-4 col-md-6 col-sm-12 mt-3">
    <article>
      <h2 class="ad-description">Collar for Sale!</h2>
      <%= image_tag image_url('ad.jpg'), class: "ad-photo", alt: "Photo of ad" %>
    </article>
  </div>
<% end %>
```

# Frontend

## Display profile images in a functioning carousel (for the dog detail page that has more than one profile image)

app/views/show.html.erb
```ruby
<h2 class="text-center"><%= @dog.name %></h2>
<% if @dog.images.length > 1 %>
  <section class="pt-3">
  <div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <% @dog.images.each_with_index do |image, n| %>
        <li data-target="#myCarousel" data-slide-to="<%= n %>" class="<%= n == 0 ? 'active' : '' %>"></li>
      <% end %>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
      <% @dog.images.each_with_index do |image, n| %>     
        <div class="item <%= n == 0 ? 'active' : '' %>">
          <%= image_tag url_for(image) %>
        </div>
      <% end %>
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
</section>
<% else %>
  <% @dog.images.each do |image| %>
    <%= image_tag url_for(image), class: "item-image mx-auto d-block", alt: "Photo of #{@dog.name}" %>
  <% end %>
<% end %>

<section>
  <p class="dog-description text-large"><%= @dog.description %></p>
  <h2 class="text-center">Likes: <%= @dog.likes.count %></h2>

  <div class="text-center text-large">
    <% if current_user && @dog.owner_id != current_user.id %>
      <% if @like %>
        <%= link_to "Unlike", like_url(@like.id), method: :delete %>
      <% else %>
        <%= link_to "Like", dog_likes_url(@dog), method: :post %>
      <% end %>
    <% end %>

    <% if current_user && current_user.id == @dog.owner_id %>
      <%= link_to "Edit #{@dog.name}'s Profile", edit_dog_path %>
      <%= link_to "Delete #{@dog.name}'s Profile", dog_path, method: :delete, data: { confirm: 'Are you sure?' } %>
    <% end %>
  </div>
</section>
```

## Use flexbox, CSS grids, or a grid framework to display the homepage's dog profile thumbnails in a responsive grid layout

app/views/_dogs.html.erb
```ruby
<div class="container text-center">
  <div class="text-right mb-3 text-dark text-large">
    <%= link_to "Sort By Likes", :controller => "dogs", :action => "index", :sort_params => true  %>
  </div>
  <div class="row">
    <%= render partial: 'thumbnail', collection: @dogs, as: :dog %>
 </div>
  <div id="page_links">
    <%= will_paginate @dogs, renderer: BootstrapPagination::Rails %>
  </div>
</div>
```

## Use utility classes within a layout framework (Bootstrap, Foundation, Material Design, or another) to add a structured layout to the page without custom CSS.

The use of utility classes with Bootstrap can be seen throughout the application.

## Refactor the homepage from its current state as a server-rendered page to a client-rendered page, where you request data from `/dogs.json` and display data from the response.

Adds clicking functionality that triggers an ajax request when page number is clicked. <br />
<br />
app/view/index.html.erb 
```html
<script>
  $(function(){
    $('.pagination a').attr('data-remote', 'true')
  });
</script>
```
Created a javascript view to replace the contents in dogs with paged table data such that clicking on a page triggers an ajax request. <br />
<br />
app/views/index.js.erb 
```javascript
$("#dogs").html('<%=  escape_javascript(render 'dogs') %>');
$('.pagination a').attr('data-remote', 'true');
```