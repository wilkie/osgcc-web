class OSGCCWeb
  configure :test do
    MongoMapper.database = 'osgcc_test'
  end

  configure :development do
    MongoMapper.database = 'osgcc_development'
  end
end
