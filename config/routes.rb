# from generate scaffold products
Rails.application.routes.draw do
    resources :products
end

# TO DO: replace above & implement to add fakestore handling
# include creation of FakestoreControler, etc.
# Rails.application.routes.draw do
#     resources :products do
#         resources :fake_store
#     end
# end

