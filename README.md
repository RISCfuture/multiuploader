MultiUploader
=============

A Ruby on Rails engine that adds drag-and-drop streaming multi-file uploader
that uses strictly modern standard Web technologies.

|             |                                 |
|:------------|:--------------------------------|
| **Author**  | Tim Morgan                      |
| **Version** | 1.0.1 (Nov 9, 2013)             |
| **License** | Released under the MIT license. |

About
-----

This gem adds a JavaScript library that draws a drag-and-drop target. When a
file is dragged to this target, it is queued for upload. Files are uploaded to
an endpoint with a configured amount of maximum parallel uploads. JavaScript
callbacks are used to track file progress.

In addition to the uploader itself, a higher-level abstraction, called
"EasyUploader", is also included. EasyUploader is powered by MultiUploader, but
also includes a quick-'n'-ugly™ user interface. You can use EasyUploader to
quickly start testing MultiUploader in your app, or you can even use it in
production if you really hate rolling your own designs. It also makes for
excellent example code for learning MultiUploader!

### Requirements

* **Rails 3.1**: This gem uses Rails engines.
* **jQuery**: The carousel and lightbox is rendered and managed using jQuery.
* **Sass**: The carousel layout is written using SCSS.

#### Client Requirements

For people to use this gem, they will need support for XmlHttpRequest level 2
and the JavaScript drag-and-drop API. If you use the theme that ships with this
gem, your clients will also need CSS level 3. All of these are supported on
recent versions of Safari and Google Chrome.

Installation
------------

To use this gem, add to your Gemfile:

```` ruby
gem 'multiuploader'
````

To your `application.js` file (or some other JavaScript manifest file), add:

```` javascript
//= require multiuploader
````

You may also need to add the following if it is not already there:

```` javascript
 //= require jquery
 ````

### EasyUploader

If you wish to additionally use EasyUploader, you must add the following to
your `application.css` file (or some other CSS manifest file);

 ```` css
 /*
  *= require easyuploader
  */
````

To your `application.js` file (or some other JavaScript manifest file), add:

```` javascript
//= require easyuploader
````

Usage
-----

We'll get started with EasyUploader first, since that's the ... easiest. If you
want to skip the baby stuff and get right into hot hot adult uploading, flip to
the next subsection.

### EasyUploader

All you need to do to start using EasyUploader is create a DIV element and call
the `easyUploader` jQuery method on it:

```` javascript
$('#easyuploader').easyUploader("http://some/endpoint", 'file');
````

The first parameter is the URL to upload the files to, and the second is the
name of the form field to associate the file data with. The encoding will always
be `application/x-www-form-urlencoded`.

If you use the `easyuploader` ID, the styles in the `easyuploader.css.scss.erb`
file will kick in and you should get an instant drag-and-drop target. Drag one
or more files in there and you should start seeing the magic happen on your
server.

There is a third parameter, not used above, that allows you to pass in
additional options to the underlying MultiUploader:

```` javascript
$('#easyuploader').easyUploader("http://some/endpoint", 'file', {
    maxSimultaneousUploads: 4
});
````

Read the MultiUploader documentation for a full list of options.

### MultiUploader

For more low-level control of the upload process, you'll need to use
MultiUploader directly. The signature is the same as EasyUploader:

```` javascript
$('#easyuploader').multiUploader("http://some/endpoint", 'file');
````

The only difference is, this time you need to implement the callbacks yourself.
There are four: `startHandler`, `progressHandler`, `loadHandler`, and
`errorHandler`. Their method signatures are as follows:

```` javascript
$('#easyuploader').multiUploader("http://some/endpoint", 'file', {
    startHandler: function(file_unique_id, file) {
        // called when a file begins uploading
    },
    progressHandler: function(file_unique_id, state, position, total) {
        // called periodically as a file is uploaded
        // (position/total)*100 gives the percent complete
    },
    loadHandler: function(file_unique_id, xhr) {
        // called when the upload is complete and the response has been received
        // use the xhr (an XmlHttpRequest instance) to get response data
    },
    errorHandler: function(file_unique_id, xhr) {
        // called when the upload fails or an error response is received
        // same arguments as loadHandler
    }
});
````

Notice that each callback receives a unique ID for the file. These are randomly
generated and have no meaningful information. They're just used to keep track of
your files. You should associate each upload's unique ID with the page element
that displays its progress.

Also note that the `startHandler` will not necessarily be called the moment the
user releases his mouse button.  If the `maxSimultaneousUploads` option is set,
additional uploads beyond this number will be queued and put into a pending
state until an "upload slot" is vacated.

The `progressHandler` method receives a state parameter. The value will be
"upload" when the file is uploading, and "download" when the upload has
completed and the client is downloading the server's response.

For more information, and a list of additional options, see the MultiUploader
class documentation.
