module Reflection
  module AssociationReflection
    extend ActiveSupport::Concern

    def get_hash_from_conditions
      self.options[:conditions] || {}
    end

    def get_id_from_child(record)
      if parent = record.send(self.active_record.name.underscore)
        parent.id || nil
      end
    end

    def failed_on_conditions?(record)
      conditions_hash = get_hash_from_conditions
      if conditions_hash.any?
        conditions_hash.each_pair{|key,value|
          return true unless record[key].to_s == value.to_s
        }
      end
      false
    end

    def match_all_conditions?(record)
      conditions_hash = get_hash_from_conditions
      if conditions_hash.any?
        changed = corresponds_to_conds = []
        conditions_hash.each_pair{|key,value|
          return true if record.send("#{key}_changed?")
        }
      end
      false
    end

  end

  module ThroughReflection
    extend ActiveSupport::Concern

    def get_hash_from_conditions
      cond_hash = super
      return cond_hash if cond_hash.empty?
      cond_hash[self.class_name.underscore.pluralize.to_sym] || {}
    end

    def get_id_from_child(record)
      if self.through_reflection
        if through = record.send(self.through_reflection.name.to_s.singularize)
          if parent = through.send(self.active_record.name.underscore)
            parent.id || nil
          end
        end
      end
    end

  end
end

ActiveRecord::Reflection::AssociationReflection.send :include, Reflection::AssociationReflection
ActiveRecord::Reflection::ThroughReflection.send :include, Reflection::ThroughReflection
