class TeamMemberState {
  final bool isInitialLoading;
  final String? errorMessage;

  const TeamMemberState({
    this.isInitialLoading = false,
    this.errorMessage,
  });

  TeamMemberState copyWith({
    bool? isInitialLoading,
    String? errorMessage,
  }) {
    return TeamMemberState(
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      errorMessage: errorMessage,
    );
  }
}