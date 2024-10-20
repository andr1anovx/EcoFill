import SwiftUI
import FirebaseAuth

struct SettingScreen: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @State private var isShownEmailView: Bool = false
    @State private var isShownAlert: Bool = false
    @State private var password: String = ""
    
    var body: some View {
        if let user = userVM.currentUser {
            ZStack {
                Color.primaryBackground.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 10) {
                    Row(data: user.initials, image: "user", imageColor: .accent)
                    Row(data: user.email,
                        image: userVM.isEmailVerified ? "userCheckmark" : "userXmark",
                        imageColor: userVM.isEmailVerified ? .accent : .red)
                    
                    Text(userVM.isEmailVerified 
                         ? "Email is confirmed."
                         : "A confirmation link has been sent to your email.")
                    .font(.poppins(.medium, size: 12))
                    .foregroundStyle(.primaryReversed)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Btn(title: "Update email",
                            image: "square",
                            color: .accent) {
                            isShownEmailView.toggle()
                        }
                        Btn(title: "Delete account",
                            image: "xmark",
                            color: .primaryRed) {
                            isShownAlert.toggle()
                        }
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.horizontal)
                .navigationTitle("Settings")
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        BackBtn()
                    }
                }
                .onAppear {
                    userVM.checkEmailVerificationStatus()
                }
                .sheet(isPresented: $isShownEmailView) {
                    UpdateEmailView()
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(20)
                }
                .alert(item: $userVM.alertItem) { alert in
                    Alert(title: alert.title,
                          message: alert.message,
                          dismissButton: alert.dismissButton)
                }
                .alert("Confirm password", isPresented: $isShownAlert) {
                    SecureField("", text: $password)
                    Button("Delete", role: .destructive) {
                        Task {
                            await userVM.deleteUser(with: password)
                        }
                    }
                }
            }
        } else {
            ProgressView("Loading user data...")
        }
    }
}
