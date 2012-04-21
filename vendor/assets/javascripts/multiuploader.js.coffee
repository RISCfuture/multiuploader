# A drag-and-drop multi-file uploader using strictly modern standard Web
# technologies.
#
# Use the `$(...).multiUploader(...)` method for a more jQuery-like syntax.

class MultiUploader

  # Creates a new upload manager. Files dropped into `elem` will be uploaded (or
  # queued for upload). The callbacks will be invoked at each phase of each
  # file's upload.
  #
  # @param [jQuery element array] elem The drop target.
  # @param [String] url The URL endpoint to post files to.
  # @param [String] name The name of the file field.
  # @param [Object] options Additional options.
  # @option options [Integer] maxSimultaneousUploads The maximum number of
  #   parallel uploads. If not set, unlimited.
  # @option options [String] method ("POST") The request method.
  # @option options [Object] data Additional key-value pairs to include in the
  #   request form body.
  # @option options [Function] startHandler Called when a file begins uploading.
  # @option options [Function] progressHandler Called when some file data is
  #   uploaded.
  # @option options [Function] loadHandler Called when a file finishes
  #   uploading.
  # @option options [Function] errorHandler Called when a file upload fails or a
  #   bad response is received.
  #
  constructor: (elem, @url, @name, @options={}) ->
    @method = @options.method || 'POST'
    @element = $(elem)

    @activeUploads = 0
    @successfulUploads = 0
    @failedUploads = 0
    @pendingUploads = []

    @element.bind 'dragenter', (event) ->
      event.stopPropagation()
      event.preventDefault()
      false
    @element.bind 'dragover', (event) ->
      event.stopPropagation()
      event.preventDefault()
      false
    @element.bind 'drop', this.drop

  # @private
  drop: (event) =>
    event.stopPropagation()
    event.preventDefault()

    @element.text ''

    $.each event.originalEvent.dataTransfer.files, (_, file) =>
      this.upload file

  # @private
  isFinished: =>
    @activeUploads == 0 && @pendingUploads.length == 0

  # @private
  isFailed: =>
    @failedUploads > 0

  # Uploads a file, or enqueues it for uploading.
  #
  # @param [File] file The file to upload.
  #
  upload: (file) =>
    if @options.maxSimultaneousUploads && @activeUploads > @options.maxSimultaneousUploads
       @pendingUploads.push file
       return

    @activeUploads++
    uid = Math.round(Math.random()*0x1000000).toString(16); # so that the listeners can keep their files apart
    @options.startHandler(uid, file) if @options.startHandler

    xhr = new XMLHttpRequest()

    data = new FormData()
    data.append @name, file
    if @options.data
      for key, value of @options.data
        do (key, value) -> data.append key, value

    xhr.addEventListener 'load', (event) =>
      @activeUploads--
      if xhr.status >= 400 then @failedUploads++ else @successfulUploads++
      this.upload @pendingUploads.pop() if @pendingUploads.length > 0
    xhr.addEventListener 'error', (event) =>
      @activeUploads--
      @failedUploads++
      this.upload @pendingUploads.pop() if @pendingUploads.length > 0

    if @options.progressHandler
      xhr.upload.addEventListener 'progress', (event) =>
        @options.progressHandler uid, 'upload', event.position, event.total
      xhr.addEventListener 'progress', (event) =>
        @options.progressHandler uid, 'download', event.position, event.total
    if @options.errorHandler
      xhr.addEventListener 'error', (event) =>
        @options.errorHandler uid, xhr
    if @options.loadHandler
      xhr.addEventListener 'load', (event) =>
        @options.loadHandler uid, xhr

    xhr.open @method, @url, true
    xhr.send data

$.fn.extend

  # Creates a new file uploader using the target element as the drop zone.
  #
  # @param [String] url The URL endpoint to post files to.
  # @param [String] name The name of the file field.
  # @param [Object] options Additional options to pass to {MultiUploader}.
  # @return [MultiUploader] The new upload manager.
  #
  multiUploader: (url, name, options={}) ->
    new MultiUploader(this, url, name, options)
