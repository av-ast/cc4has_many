module HasManyCounterCache
  extend ActiveSupport::Concern

  included do
    self.valid_options += [:primary_key, :dependent, :as, :through, :source, :source_type, :inverse_of, :counter_cache]
  end

  def build
    reflection = super
    add_counter_cache_callbacks(reflection) if options[:counter_cache]
    configure_dependency
    reflection
  end

  private

  def add_counter_cache_callbacks(reflection)
    if counter_cache_name = reflection.counter_cache_column
      ref_class = reflection.class_name.constantize
      ref_class.instance_eval do

        after_create do |record|
          id = reflection.get_id_from_child record
          reflection.active_record.increment_counter(counter_cache_name, id) unless reflection.failed_on_conditions?(record)
        end

        after_update do |record|
          id = reflection.get_id_from_child record
          if reflection.failed_on_conditions?(record)
            reflection.active_record.decrement_counter(counter_cache_name, id)
          else
            if reflection.match_all_conditions?(record)
              reflection.active_record.increment_counter(counter_cache_name, id)
            end
          end
        end

        after_destroy do |record|
          id = reflection.get_id_from_child record
          reflection.active_record.decrement_counter(counter_cache_name, id) unless reflection.failed_on_conditions?(record)
        end

      end
    end
  end

end

ActiveRecord::Associations::Builder::HasMany.send :include, HasManyCounterCache

