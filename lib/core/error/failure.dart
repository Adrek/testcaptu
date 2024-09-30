abstract class Failure {}

class UnknownFailure extends Failure {}

class ServerFailure extends Failure {}

class LoginFailure extends Failure {}

class LocationPermissionFailure extends Failure {}

class LocationPermissionDeniedFailure extends Failure {}

class LocationServiceDisabledFailure extends Failure {}
