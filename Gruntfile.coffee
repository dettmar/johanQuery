module.exports = (grunt) ->

	@initConfig
		
		'http-server':
			dev:
				root: './tests/'
				port: 8080
				runInBackground: true
				cache: 1
			prod:
				root: './tests/'
				port: 8080
				runInBackground: false
				cache: 1
		
		watch:
			files: 'johanQuery.coffee',
			tasks: ['coffee', 'uglify']
		
		coffee:
			options:
				sourceMap: true
			compile:
				files:
					'johanQuery.js': 'johanQuery.coffee'
		
		uglify:
			options:
				report: 'gzip'
				sourceMap: true
				sourceMapName: 'tests/johanQuery.min.js.map'
				preserveComments: 'some'
			my_target:
				files:
					'tests/johanQuery.min.js': ['johanQuery.js']
	
	@loadNpmTasks 'grunt-contrib-watch'
	@loadNpmTasks 'grunt-contrib-coffee'
	@loadNpmTasks 'grunt-contrib-uglify'
	@loadNpmTasks 'grunt-http-server'

	@registerTask 'default', [
		'coffee'
		'uglify'
		'http-server:dev'
		'watch'
	]