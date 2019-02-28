FactoryBot.define do 
    factory :role do
        rolename {["Developer", "Manager", "Tester"].sample}
    end
end