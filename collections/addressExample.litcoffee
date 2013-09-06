Example for simple-schema
===



      @Address = (city, state) ->
        this.city = city
        this.state = state

      @Address:: =
        constructor: Address

        toString: () ->
          @city + ',' + @state
     
        clone: () ->
          new Address @city, @state

        equals: (other) ->
          if not (other instanceof Address) then return false

        typeName: () ->
          "Address"

        toJSONValue: () ->
          return {
            @city
            @state
          }

      EJSON.addType "Address", (value)->
        console.log value
        new Address value.city, value.state


      @person =
        name: "Chris Mather"

        createdAt: new Date()

        file: new Uint8Array([104, 101, 108, 108, 111])

        address: new Address("San Francisco", "CA")

      @person2 =
        name: "Chuck Short"

        createdAt: new Date()

        file: new Uint8Array([104, 101, 108, 108, 111])

        address: new Address("Columbia", "SC")





      @People = new Meteor.Collection "people"

      @People2 = new Meteor.Collection2 "people2", {
        schema:
          name:
            type: String
            label: "name"
            max: 200
          address:
            type: Object
            label: "address"
        }

      if (Meteor.isClient)
        Meteor.subscribe "people"
        Meteor.subscribe "people2"
        Meteor.startup ()->
          People.insert person2
          People2.insert person2

      if (Meteor.isServer)
        Meteor.publish "people", ()->
          @added "people", Meteor.uuid(), person
          @ready()
        Meteor.publish "people2", ()->
          @added "people2", Meteor.uuid(), person
          @ready()


