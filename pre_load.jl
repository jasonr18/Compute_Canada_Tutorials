# This is the file for precompiling self-created packages in niagara system

if !("." in LOAD_PATH)
    push!(LOAD_PATH, ".") # path to your-own-module
end

using process_model