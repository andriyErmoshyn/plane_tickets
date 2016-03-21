# Plane tickets booking demo

yermoshin-tickets.herokuapp.com

* Users system
  - new user registration;
  - updating user's profile;
  - password reset;

* Roles system:
  - managing roles with CanCanCan;
  - roles: user, admin;
  - *Admin:*
    - admin credits: email: "admin@user.com", password: "password";
    - creates/updates routes;
    - can approve/reject the ticket order and send the respective email to the user;
  - *User:*
    - can update his profile;
    - can buy tickets;

* Routes system
  - creating/updating routes by admin;
  - sorts by departure time, flight duration or price;
  - default sorting: by depart in ascending order;

* Routes search system
  - available for any role user;
  - available by departure or arrival or date;
  - routes with changes available (to test functionality make a search: Sofia - Rome on 2016-03-25);
  - you can see all routes from/to specified city by click on it;

* Tickets system
  - tickets ordering available for authorized users only;
  - after purchasing the ticket info appears in users profile with status 'In awaiting';
  - after approving/rejection by admin the user gets the respective email, the ticket status changes;

* Tests:
   - Rspec, Capybara, Faker;
   - simplecov.
