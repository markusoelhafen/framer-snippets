sections = {
	Section1:
		options: ["Option1", "Option2", "Option3"],
	Section2:
		options: ["Option1", "Option2", "Option3", "Option4"],
	Section3:
		options: ["Option1", "Option2"],
	Section4:
		options: ["Option1", "Option2", "Option3"],
	Section5:
		options: ["Option1", "Option2", "Option3", "Option4", "Option5"],
	Section6:
		options: ["Option1", "Option2", "Option3"]
}

margin = 20

previousRow = null

accordeon = new ScrollComponent
	width: Screen.width
	height: Screen.height
accordeon.scrollHorizontal = false

for section, content of sections
	section = new Layer
		parent: accordeon.content
		height: 100
		width: accordeon.width
		backgroundColor: "lightblue"
		clip: true
		color: "#1a1a1a"
		html: section
	section.style = 
		"text-align" : "center"
		"padding" : "35px 0"
			
	section.previousRow = previousRow
	
	if previousRow
		previousRow.row = section
		previousRow.row.y = previousRow.maxY + margin
	
	for options, items of content
		for item, i in items
			item = new Layer
				parent: section
				height: 80
				width: section.width - 100
				x: 50
				y: (section.height + margin) * i + section.height
				backgroundColor: "rgba(0,0,0,0.1)"
				html: item
			item.style =
				"padding" : "25px 0"
				
	section.states.add
		open: height: section.contentFrame().height + section.height + (margin * 2)
	section.states.animationOptions =
		curve: "ease"
		time: 0.33
		
	section.on Events.Click, ->
		if @.previousRow != null
			@states._states["default"].y = @previousRow.maxY + margin
		@states.next()
		
	previousRow?.on "change:frame", ->
		@row?.y = @maxY + margin
		
	previousRow = section
				