use bounty_client::Client;
use frusty_logger::{Config, FilterBuilder};
use log::Level;

frusty_logger::include_ffi!(
  with_config: Config::new(
    Level::Info,
    FilterBuilder::new()
    .parse("sunshine,sc_information,substrate_subxt")
    .build()
  )
);

bounty_ffi::impl_ffi!(client: Client);

/// a hack to make iOS link to this lib
#[inline(never)]
#[no_mangle]
pub extern "C" fn link_me_please() {}
