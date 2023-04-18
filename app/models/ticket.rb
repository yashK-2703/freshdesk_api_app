class Ticket < ApplicationRecord
	self.inheritance_column = :foo
end
