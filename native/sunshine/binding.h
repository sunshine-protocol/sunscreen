#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>


/**
 * Approve a Submission using `SubmissionId`
 * Returns the new total amount on that bounty after this operation
 */
int32_t client_bounty_approve(int64_t port, uint64_t submission_id);

/**
 * Contribute to a bounty.
 * Returns the new total bounty amount
 */
int32_t client_bounty_contribute(int64_t port, uint64_t bounty_id, uint64_t amount);

/**
 * Get a bounty Information by using bounty Id
 * Returns Cbor encoded `BountyInformation` as bytes
 */
int32_t client_bounty_get(int64_t port, uint64_t bounty_id);

/**
 * Get a submission Information by using submission Id
 * Returns Cbor encoded `BountySubmissionInformation` as bytes
 */
int32_t client_bounty_get_submission(int64_t port, uint64_t submission_id);

/**
 * Get a list of open bounties.
 * Returns a Cbor encoded list of `BountyInformation` as bytes.
 */
int32_t client_bounty_open_bounties(int64_t port, uint64_t min);

/**
 * Get a list of open submissions on a bounty.
 * Returns a Cbor encoded list of `BountySubmissionInformation` as bytes.
 */
int32_t client_bounty_open_bounty_submissions(int64_t port, uint64_t bounty_id);

/**
 * Create a new Bounty
 * Returns the `BountyId` as `u64`
 */
int32_t client_bounty_post(int64_t port,
                           const char *repo_owner,
                           const char *repo_name,
                           uint64_t issue_number,
                           uint64_t amount);

/**
 * Create a submission on a bounty
 * Returns the `SubmissionId` as `u64`
 */
int32_t client_bounty_submit(int64_t port,
                             uint64_t bounty_id,
                             const char *repo_owner,
                             const char *repo_name,
                             uint64_t issue_number,
                             uint64_t amount);

/**
 * Setup the Sunshine Client using the provided path as the base path and with chainspec
 *
 * ### Safety
 * This assumes that the path and chain_spec is non-null c string.
 */
int32_t client_init(int64_t port, const char *path, const char *chain_spec);

/**
 * Check if the Logger is already initialized to prevent any errors of calling init again.
 * return 1 if initialized before, 0 otherwise.
 */
int32_t frusty_logger_is_initialized(void);

/**
 * a hack to make iOS link to this lib
 */
void link_me_please(void);
