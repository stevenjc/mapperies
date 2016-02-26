class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  <% if signed_in? %>
     Signed in as: <%= current_user.email %>
     <%= button_to 'Sign out', sign_out_path, method: :delete %>
   <% else %>
     <%= link_to 'Sign in', sign_in_path %>
   <% end %>

   <div id="flash">
     <% flash.each do |key, value| %>
       <div class="flash <%= key %>"><%= value %></div>
     <% end %>
   </div>

end
