class Gurupu.Models.Tags extends Backbone.Model
  paramRoot: 'tag'

  defaults:
    id: null
    name: null
class Gurupu.Collections.TagsCollection extends Backbone.Collection
  model: Gurupu.Models.Tags
  url: ''
