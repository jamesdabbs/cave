Cave
=====

A simple Ruby form library, intended for use with Rails

Largely inspired by Code Climate's [7 Patterns to Refactor Fat ActiveRecord Models](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/) as a method for encapsulating validation into an object with a single responsibility.

### Forms

[Cave::Form](https://github.com/jamesdabbs/cave/blob/master/lib/cave/form.rb) is a light glue layer around 
[Rails' ActiveModel::Validations](http://guides.rubyonrails.org/active_record_validations_callbacks.html) 
and [Virtus](https://github.com/solnic/virtus)' type coercion. You may want to consult their documentation for
more options.

    class FormClass < Cave::Form
      field :name, String,
        presence: true,
        format: { :with => /\A[a-zA-Z]+\z/, :message => "Only letters allowed" }
        # Takes any number of standard Rails validation helper options
      field :favorite_number, Integer,
        inclusion: { :in => 1..10 }

      def persist!
        # Define your persistence logic here.
        # This method will be called whenever a valid form is saved.
        "Form saved!"
      end
    end

    form = FormClass.bind name: 'James Dabbs', favorite_number: 11
    form.valid?
    => false
    form.errors.full_messages
    => ["Name Only letters allowed", "Favorite number is not included in the list"]

    form = FormClass.bind name: 'jamesdabbs', favorite_number: '7'
    form.valid?
    => true
    form.favorite_number
    => 7  // Note the type coercion
    form.save!
    => "Form saved!"

###Forms for Models

For the common use case of creating or updating a model with a form, Cave provides
the [Cave::ModelForm](https://github.com/jamesdabbs/cave/blob/master/lib/cave/model_form.rb) class.

    class ProfileForm < Cave::ModelForm
      model Profile

      field :name, String, presence: true
      field :age,  Integer
    end

    ProfileForm.bind(name: 'James').save!  # Creates a new Profile named 'James'

    instance = Profile.first
    ProfileForm.bind(instance, name: 'Jim').save!  # Updates the Profile's name

###Planned features

- Add presenters for rendering forms into html (inc. a bootstrap template)
- Improve handling of intial values (as for unbound ModelForms)
- Write docs
- Requests?