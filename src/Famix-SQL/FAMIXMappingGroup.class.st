Class {
	#name : #FAMIXMappingGroup,
	#superclass : #MooseGroup,
	#category : #'Famix-SQL-Group'
}

{ #category : #'as yet unclassified' }
FAMIXMappingGroup class >> annotation [
	<MSEClass: #MappingGroup super: #MooseGroup>
	<package: #FAMIX>
	^ self
]

{ #category : #'as yet unclassified' }
FAMIXMappingGroup >> saveListOfMapsOnFile [
	| stream fileName |
	
	fileName := UIManager default request: 'Insert a file name'.
	
	(fileName isNil or: [fileName = '']) 
		ifTrue: [ DialogWindow new alert: 'Invalid file name']
		ifFalse: [self saveListOfMapsOnFileNamed: fileName].
]

{ #category : #'as yet unclassified' }
FAMIXMappingGroup >> saveListOfMapsOnFileNamed: aString [
	| stream |
	
	stream := MultiByteFileStream forceNewFileNamed: aString.
	self do: [:map |
				stream nextPutAll: (map from mooseName asString , Character space asString , map to name asString , String cr asString)].	
	stream close.
			
	^stream
]
