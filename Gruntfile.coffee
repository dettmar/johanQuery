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
			options:
				livereload: true
			dev:
				files: 'johanQuery.coffee',
				tasks: ['coffee:dev', 'uglify']
			tests:
				files: ['tests/tests.coffee', 'tests/index.html']
				tasks: ['coffee:tests']
			
		
		coffee:
			options:
				sourceMap: true
			dev:
				files:
					'johanQuery.js': 'johanQuery.coffee'
			tests:
				files:
					'tests/tests.js': 'tests/tests.coffee'
		
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
		'coffee:dev'
		'coffee:tests'
		'uglify'
		'http-server:dev'
		'watch'
	]