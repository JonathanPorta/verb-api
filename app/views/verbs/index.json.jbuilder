@verbs.each do |category, verbs|
  json.set! category do
    json.array! verbs
  end
end
