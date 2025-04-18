import { MobileHeader } from "@/components/mobile-header";
import { Sidebar } from "@/components/sidebar";


type Props={
    children: React.ReactNode;
};

//pt = padding top
//mx-auto to adjust the Learn page size, like it will not expand after 1056px

const MainLayout=({
    children,
}: Props) =>{
    return(
        <>
        <MobileHeader/>
        <Sidebar className="hidden lg:flex"/> 
        <main className="lg:pl-[254px] h-full pt-[50px] lg:pt-0">
            <div className="max-w-[1056px] mx-auto pt-6 h-full">
            {children}
        </div>
        </main>
        </>
    )
}

export default MainLayout;