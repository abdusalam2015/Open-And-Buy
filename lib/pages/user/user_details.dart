
class UserDetail2{
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String email;
  final List<ProviderDetail> providerData;
  UserDetail2(this.providerDetails, this.userName, this.photoUrl, this.email, this.providerData);
}
class ProviderDetail{
  final String providerDetails;
  ProviderDetail(this.providerDetails);
}