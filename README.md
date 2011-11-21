Hamlbars
========

Hamlbars is a gem for using HAML with Handlebars JavaScript templates.

Usage
------

Define files with the `.hamlbars` extension. Write your Handlebar JS templates using HAML in these files. Hamlbars will compile them into HTML and register the compiled templates into a `TEMPLATES` JavaScript object for use client side.

Let's use an example. Imagine I'm working on a rich internet application that has a homepage, about page, contact page and allows for viewing and creation of accounts. I might have the following directory structure (assuming Rails 3.1 asset pipeline):
  
    app
      -> assets
        -> app
          -> models
          -> controllers
          -> views
            -> home
              -> index
              -> about
              -> contact
            -> accounts
              -> new
              -> edit
              -> show

In my JavaScript controllers, I'm going to need to reference my views. I want to use Handlebars (because it's awesome) client side, but I also want to use HAML (because it is similarly awesome) server side. I also want to take advantage of any helpers I define and any Rails helpers, because they make my code easier to read.

Hamlbars was designed for you to do exactly this. Fill your view files with HAML, just like any normal server side view and use the extension `.hamlbars`. Then, in your JavaScript, access the compiled templates with : `window.TEMPLATES[sprockets logical path]`. For example, to access the "about" page view in the above example you would use :

    window.TEMPLATES["app/views/home/about"]

Caveat
-------

Many helpers require a request object to work properly. Although all these ActionView helpers are included in the scope of the HAML renderer, certain helpers will not work without access to this request object. As Sprockets does not have access to this, and most production templates will be compiled outside of a request cycle, there is no reasonable way to make all these helpers work universally. They are included so that the individual programmer can take steps to make these helpers work on a case by case basis as needed.

I have taken efforts to enable usage of rails routing helpers, however. If you define `Rails.application.config.default_url_options`, these options will be extended to the HAML scope context, allowing for usage of all `{path}_url` methods.

For example, I have the following in my `development.rb` file :

    config.action_controller.default_url_options = {:host => "www.rails.loc:3000"}
  
Questions? Comments?
--------------------

Find me, Jesse Reiss, at [the gorgon lab](http://www.thegorgonlab.com)
    