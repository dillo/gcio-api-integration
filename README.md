##### by Dillo Raju
# GovCIO API Integration

### Overview

Take home Ruby on Rails project.

* **Ask:**

     * _"Prototype a Rails API for integrating with the [Fakestore API](http://fakestoreapi.com/)"_
     *  _"Given a [Fakestore API](http://fakestoreapi.com/) that contains a list of products, create an integration
     between the Rails API and the Fakestore's [products](http://fakestoreapi.com/products) JSON endpoint"_
     * _"Create a Rake `task` that can trigger the Rails API to make a GET request to the Fakestore's `products` endpoint
     and successfully retrieve a list of products as JSON"_
     * _"Create appropriate Active Record models(make your own determination on what's needed) and persist the products data that was
     fetched from the previous step into the Postgresql database"_
     * _"Create a REST endpoint on the Rails API that can be used to search for products by a given price range and category. The result set
     should be returned as an array of products and as JSON"_

* **Example Rails API search endpoint:**

    * -"http://localhost:3000/products?category=FOO&price=100,200"_

* **Notes:**

     * _You can't do it all. We respect your time, and expect that you will have to make 
        choices and tradeoffs for what is in scope for your deliverable._
     * _Don't worry about authentication. Assume a non-authenticated experience to keep things simple._
     * _Pick your stack. Choose any gems that help you produce the highest quality work in the time available._
    
