"
FAMIXDeleteRequest corresponds to a delete request.
"
Class {
	#name : #FAMIXDeleteRequest,
	#superclass : #FAMIXRequest,
	#category : #'Famix-SQL-Core'
}

{ #category : #meta }
FAMIXDeleteRequest class >> annotation [
	<MSEClass: #DeleteRequest super: #FAMIXRequest>
	<package: #SQL>
	^self
]
