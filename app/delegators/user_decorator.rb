class UserDecorator < DelegateClass(User)
    def name
        return self.name if not self.name.empty?
        "Anonymous"
    end
end