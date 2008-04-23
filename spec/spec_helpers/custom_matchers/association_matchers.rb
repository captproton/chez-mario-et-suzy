# Generic class for association matchers
# Thanks to boof (http://snippets.dzone.com/user/boof)
class AssociationReflection
  def initialize(type, name)
    @messages = {
      :missing_association =>
        '%s is not associated with %s.',
      :wrong_type =>
        "%s %s %s./nExpected: %s",
      :wrong_options =>
        "Options are incorrect.\nExpected: %s Got: %s",
      :missing_column =>
        "Missing foreign key.\nExpected: %s"
    }
    @name = name
    @expected_type = type
    @expected_options = {}
  end
  
  def matches?(target)
    Class === target or
    raise ArgumentError, 'class expected'

    @target = target

    unless @assoc = target.reflect_on_association(@name)
      @failure = :missing_association
      return false
    end 

    unless @assoc.macro.eql?(@expected_type)
      @failure = :wrong_type
      return false
    end

    if @expected_options.any? { |o| @assoc.options[o.first] != o.last }
      @failure = :wrong_options
      return false
    end

    @column ||= @assoc.primary_key_name || @assoc.klass.name.foreign_key

    @failure = case @assoc.macro.to_s
    when 'belongs_to'
      if @target.column_names.include?(@column.to_s) then nil
      else
        :missing_column
      end
    when /(?:has_many|has_one)/
      if    @assoc.options[:through] then nil
      elsif @assoc.klass.column_names.include?(@column.to_s) then nil
      else
        :missing_column
      end
    end

    return @failure.nil?
  end

  def failure_message
    case @failure
    when :missing_association
      @messages[@failure] % [@target.name, @name]
    when :wrong_type
      @messages[@failure] % [
        @target.name,
        @assoc.macro,
        @name,
        @expected_type
      ]
    when :wrong_options
      @messages[@failure] % [
        @expected_options.inspect,
        @assoc.options.inspect
      ]
    when :missing_column
      @messages[@failure] % @column
    end
  end
  
  # Avoid using should_not with association matchers
  def negative_failure_message
  end

  # Specifies an association with option :class_name => ClassName
  def using_model(class_name)
    class_name = class_name.name if Class === class_name
    @expected_options[:class_name] = class_name
    self
  end
  
  # Specifies an association with option :foreign_key => "foreign_key"
  def using_key(foreign_key)
    @column = foreign_key
    self
  end
  
  # Specifies an association with option :conditions => 'condition SQL fragment'
  def due_to(conditions)
    @expected_options[:conditions] = conditions
    self
  end
  
  # Specifies an association with option :order => 'order SQL fragment'
  def ordered_by(statement)
    @expected_options[:order] = statement
    self
  end
  
  # Specifies an association with option :include => [ :model1, :model2 ]
  def including(*models)
    @expected_options[:include] = (models.length == 1) ? models.first : models
    self
  end
end

# Implementation for the belongs_to association
class BelongsToReflection < AssociationReflection
  def initialize(name)
    super :belongs_to, name
  end

  # Specifies a belongs_to association with option :counter_cache => "column name"
  def counted(column)
    @expected_options[:counter_cache] = column
    self
  end
  
  # Specifies a belongs_to association with option :polymorphic => boolean_value
  def polymorphic(true_or_false = true)
    @expected_options[:polymorphic] = true_or_false
    self
  end
end

# Implementation for the has_one association
class HasOneReflection < AssociationReflection
  def initialize(name)
    super :has_one, name
  end

  # Specifies a has_one association with option :as => :interface_name
  def as(interface_name)
    @expected_options[:as] = interface_name
    self
  end
  
  # Specifies a has_one association with option :dependent => dependency_symbol
  def depending(dependency = :destroy)
    @expected_options[:dependent] = dependency
    self
  end
end

# Implementation for the has_many association
class HasManyReflection < AssociationReflection
  def initialize(name)
    super :has_many, name
  end

  # Specifies a has_many association with option :as => :interface_name
  def as(interface_name)
    @expected_options[:as] = interface_name
    self
  end
  
  # Specifies a has_many association with option :dependent => dependency_symbol
  def depending(dependency = :destroy)
    @expected_options[:dependent] = dependency
    self
  end
  
  # Specifies a has_many association with option :extend => extend_module
  def extended_by(mod)
    @expected_options[:extend] = mod
    self
  end
  
  # Specifies a has_many association with option :through => :models_name
  def through(models)
    @expected_options[:through] = models
    self
  end
end

# Implementation for the has_and_belongs_to_many association
class HasAndBelongsToManyReflection < AssociationReflection
  def initialize(name)
    super :has_and_belongs_to_many, name
  end
end

# Checks to see that a model has a belongs_to association
# with the correct model
# ===Example
#   ModelClass.should belongs_to(:another_model_class)
#   ModelClass.should belongs_to(:another_model_class).using_key("some_foreign_key")
def belong_to(model)
  BelongsToReflection.new model
end

# Checks to see that a model has a has_one association
# with the correct model
# ===Example
#   ModelClass.should have_one(:another_model_class)
def have_one(model)
  HasOneReflection.new model
end

# Checks to see that a model has a has_many association
# with the correct model
# ===Example
#   ModelClass.should have_many(:other_model_classes)
def have_many(models)
  HasManyReflection.new models
end

# Checks to see that a model has a has_and_belongs_to_many association
# with the correct model
# ===Example
#   ModelClass.should have_and_belong_to_many(:other_model_classes)
def have_and_belong_to_many(models)
  HasAndBelongsToManyReflection.new models
end
