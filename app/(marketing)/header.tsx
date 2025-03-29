import { Button } from "@/components/ui/button"
import { ClerkLoaded, ClerkLoading,ClerkProvider,SignedIn,SignedOut,SignInButton, UserButton } from "@clerk/nextjs"
import { Loader } from "lucide-react"
import Image from "next/image"


export const Header=()=>{
    return(
        <header className="h-20 w-full border-b-2 border-slate-200 px-4">
            <div className="lg:max-w-screen-lg mx-auto flex items-center justify-between h-full">
                <div className="pt-8 pl-4 pb-7 flex items-center gap-x-3">
                    <Image src="/linode.svg" height={40} width={40} alt="Mascot" priority={true}/>
                    <h1 className="test-2xl font-extrabold text-green-600 tracking-wide">
                        Lingual
                    </h1>

                </div>
                <ClerkLoading >
                    <Loader className="h-5 w-5 text-muted-foreground animate-spin"/>
                </ClerkLoading>
                
                <ClerkLoaded>
                    <SignedIn>
                        <ClerkProvider afterSignOutUrl="/">
                        <UserButton >
                        </UserButton> 
                        </ClerkProvider>          
                    </SignedIn>
                    <SignedOut>
                        <SignInButton 
                        mode="modal"
                        forceRedirectUrl ="/learn" 
                        signUpForceRedirectUrl="/learn">
                            <Button size="lg" variant="ghost">
                                Login
                            </Button>
                        </SignInButton>
                    </SignedOut>
                </ClerkLoaded>
                

            </div>
        </header>
    )
}