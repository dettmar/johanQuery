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
	
	@loadNpmTasks 'grunt-contrib-watch'
	@loadNpmTasks 'grunt-contrib-coffee'

	@registerTask 'default', [
    'coffee'
    'watch'
  ]