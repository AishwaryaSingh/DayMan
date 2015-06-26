	def validate_each(record, attribute, value)
	begin
	record.errors.add attribute, 'must point to a real mail account' unless EmailVerifier.check(value)
	rescue EmailVerifier::OutOfMailServersException
	record.errors.add attribute, 'appears to point to dead mail server'
	rescue EmailVerifier::NoMailServerException
	record.errors.add attribute, "appears to point to domain which doesn't handle e-mail"
	rescue EmailVerifier::FailureException
	record.errors.add attribute, "could not be checked if is real"
	end
	end