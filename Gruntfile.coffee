module.exports = (grunt) ->

	@initConfig
	
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
				sourceMapName: 'johanQuery.min.js.map'
				preserveComments: 'some'
			my_target:
				files:
					'johanQuery.min.js': ['johanQuery.js']
	
	@loadNpmTasks 'grunt-contrib-watch'
	@loadNpmTasks 'grunt-contrib-coffee'
	@loadNpmTasks 'grunt-contrib-uglify'

	@registerTask 'default', [
		'coffee'
		'uglify'
		'watch'
	]