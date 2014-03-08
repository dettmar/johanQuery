module.exports = (grunt) ->

	@initConfig
		watch:
			files: 'johanQuery.coffee',
			tasks: 'coffee'
		coffee:
			options:
				sourceMap: true
			compile:
				files:
					'johanQuery.js': 'johanQuery.coffee'
		uglify:
			options:
				mangle: false
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