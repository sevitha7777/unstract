import PropTypes from "prop-types";

import { ProfileInfoBar } from "../profile-info-bar/ProfileInfoBar";
import { SpinnerLoader } from "../../widgets/spinner-loader/SpinnerLoader";

function JsonViewBody({
  activeKey,
  selectedProfile,
  llmProfiles,
  combinedOutput,
  isLoading,
}) {
  if (isLoading) {
    return <SpinnerLoader />;
  }

  // Extract confidence score for display
  const combinedConfidence = combinedOutput?._combined_confidence;
  
  // Create display output without the internal confidence field
  const displayOutput = { ...combinedOutput };
  if (displayOutput._combined_confidence !== undefined) {
    delete displayOutput._combined_confidence;
  }

  return (
    <>
      {activeKey !== "0" && (
        <ProfileInfoBar profileId={selectedProfile} profiles={llmProfiles} />
      )}
      {activeKey === "0" && combinedConfidence !== undefined && (
        <div className="confidence-display" style={{ 
          padding: "8px 16px", 
          backgroundColor: "#f6f8fa", 
          border: "1px solid #d1d9e0", 
          borderRadius: "6px", 
          marginBottom: "12px",
          fontSize: "14px",
          color: "#24292f"
        }}>
          <strong>Combined Confidence: {combinedConfidence}%</strong>
        </div>
      )}
      <div className="combined-op-body code-snippet">
        {combinedOutput && (
          <pre className="line-numbers width-100">
            <code className="language-javascript width-100">
              {JSON.stringify(displayOutput, null, 2)}
            </code>
          </pre>
        )}
      </div>
    </>
  );
}

JsonViewBody.propTypes = {
  activeKey: PropTypes.string.isRequired,
  selectedProfile: PropTypes.string,
  llmProfiles: PropTypes.array,
  combinedOutput: PropTypes.object,
  isLoading: PropTypes.bool.isRequired,
};

export { JsonViewBody };
