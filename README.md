# Private Events

[The Odin Project: Private Events](https://www.theodinproject.com/lessons/ruby-on-rails-private-events)

You want to build a site similar to a private Eventbrite which allows users to create events and then manage user signups.

This project will require you to model many-to-many relationships and also to be very conscious about your foreign keys and class names (hint: you won’t be able to just rely on Rails’ defaults like you have before).

- A user can create events.
- A user can attend many events.
- An event can be attended by many users.
- Events take place at a specific date and at a location (which you can just store as a string, like “Andy’s House”).

## Setup

1. Think about and spec out how to set up your data models for this application.

2. Create a new private-events Rails app and GitHub repo.

3. Update your README to be descriptive and link to this project.

## Events and Users
1. Build and migrate your Event model without any foreign keys or validations. Include the event’s date in your model but don’t worry about doing anything special with it yet.

2. Create the EventsController and add an #index action that will display all of the events. Create a corresponding view and add a heading with your choice of wording.

3. Set up devise to handle authentication and create your User model. Set the root_path to be the Event’s Index page.

4. Add the association between the event creator (a User) and the event. Call this user the “creator”. Add the foreign key to the Event model as necessary. You’ll need to specify your association properties carefully (e.g. :foreign_key, :class_name).

5. Have the User’s Show page list all the events a user has created.

6. Update the EventsController and corresponding routes to allow you to create a new event. The #create action should use the #build association reference method to create the new event with the user’s ID prepopulated. Find the right #build association reference method for the type of association you set up between your models. You could use Event’s ::new method and manually enter the ID but… don’t.

7. Make the form for creating an event.

8. Have the Event’s Show page display the details of the event.

## Event Attendance

1. Add the association between the event attendee (also a User) and the event. Call this user the “attendee”. Call the event the “attended_event”. You’ll again need to juggle specially named foreign keys and classes and sources.

2. Create and migrate all necessary tables and foreign keys. This will require a “through” table since an Event can have many Attendees and a single User (Attendee) can attend many Events… many-to-many.

3. Create a Controller and corresponding routes for the “through” table that will allow a user to become an “attendee” of an event. This will also require creating some sort of interface in the view(s) where the user can indicate that they want to attend an event.

4. Update the Event’s Show page to display a list of attendees.

5. Add to the User’s Show page a list of their “attended_events”.

6. Separate this list of “attended_events” into either events that have occurred in the past or events that will occur in the future. You’ll get some good practice building queries and working with dates. Keep this logic in the view and do not put separate method calls in the controller.

## Finishing Touches

1. Separate the past and upcoming events on the Event’s Index page by creating two class methods on the Event model (e.g. Event.past).

2. Refactor the past and upcoming class methods into simple scopes.

3. Put navigation links across the top to help you jump around.

4. Extra Credit: Allow users to edit and delete the events they created.

5. Extra Credit: Allow users to remove themselves as an attendee to their “attended_events”.

6. Extra Credit: Make each event private and add the functionality for the event creator to invite specific users to an event.